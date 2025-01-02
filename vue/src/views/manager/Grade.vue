<template>
  <div>
    <div class="card" style="margin-bottom:18px ">
      <el-input v-model="data.courseName" style="width: 280px;margin-right: 10px" placeholder="请输入课程名称查询" :prefix-icon="Search"/>
      <el-input v-model="data.studentName" style="width: 280px;margin-right: 10px" placeholder="请输入学生名称查询" :prefix-icon="Search"/>
      <el-button type="primary" round style="margin-left: 10px"  @click="load">查询</el-button>
      <el-button type="info" round style="margin-left: 10px " @click="reset">重置</el-button>
      <el-button type="success" round style="margin-left: 50px " @click="sort('asc')">升序</el-button>
      <el-button type="success" round style="margin-right: 10px " @click="sort('desc')">降序</el-button>
    </div>
  </div>
  <div class="card " style="margin-bottom:18px;">

    <div>
      <el-table :data="data.tableData" style="width: 100%">
        <el-table-column prop="id" label="序号" width="180" />
        <el-table-column prop="courseName" label="课程名"  />
        <el-table-column prop="studentId" label="学号"/>
        <el-table-column prop="studentName" label="学生名称"/>
        <el-table-column prop="score" label="成绩"/>
        <el-table-column prop="feedback" label="学生反馈"/>
        <el-table-column prop="teacher" label="授课教师"  />
        <el-table-column label="操作" width="180" v-if="data.user.role==='ADMIN'">
        <template #default="scope">
          <el-button type="primary" @click="handleEdit(scope.row)" v-if="data.user.role==='ADMIN'">编辑</el-button>
          <el-button type="danger" @click="del(scope.row.id)" v-if="data.user.role==='ADMIN'">删除</el-button>
          <el-button type="primary" @click="handleEdit(scope.row)" v-if="data.user.role==='STUDENT'">反馈</el-button>
        </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
  <div class="card">
    <el-pagination v-model:page-size="data.pageSize" v-model:current-page="data.pageNum"
                   @current-change="handelCurrentChange"
                   background layout="prev, pager, next" :total="data.total" />
  </div>

  <el-dialog  width="35%" v-model="data.formVisible" title="重评分" >
    <el-form :model="data.form" label-width="100px" label-position="right" style="padding-right: 40px">
      <el-form-item label="课程名称" >
        <el-input v-model="data.form.courseName" autocomplete="off" disabled/>
      </el-form-item>
      <el-form-item label="评分" v-if="data.user.role==='ADMIN'">
        <el-input v-model="data.form.score" autocomplete="off" />
      </el-form-item>
      <el-form-item label="成绩" v-if="data.user.role==='STUDENT'">
        <el-input v-model="data.form.score" autocomplete="off" disabled/>
      </el-form-item>
      <el-form-item label="老师评价" v-if="data.user.role==='STUDENT'">
        <el-input type="textarea" v-model="data.form.feedback" autocomplete="off" />
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="data.formVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">保 存</el-button>
      </div>
    </template>
  </el-dialog>
</template>
<script setup>
import { reactive} from "vue";
import { Search } from '@element-plus/icons-vue'
import request from "@/utils/request";
import {ElMessage, ElMessageBox} from "element-plus";
const  data =reactive({
  form:{},
  courseName:"",
  studentName:"",
  total:0,
  teacher:"",
  tableData:[],
  pageNum: 1,//当前页数
  pageSize:10,//每一页的个数
  user :JSON.parse(localStorage.getItem('student-user')||'{}'),
  formVisible:false
})
console.log(data);
const load=() =>{
  let params={  pageNum: data.pageNum,
    pageSize: data.pageSize,
    courseName: data.courseName,
    studentName: data.studentName,
    teacher: data.teacher,
  }
  if(data.user.role ==="STUDENT"){
    params.studentId=data.user.id
  }
  if(data.user.role ==="TEACHER"){
    params.teacher=data.user.name
  }
  request.get("/grade/selectPage",{
    params:params
  }).then(res=>{
    data.tableData = res.data?.list || []
    data.total = res.data.total || 0
  })
}
//调用方法获取数据
load();
const handelCurrentChange = () => {
  //翻页后重新加载数据页面
  load()
}
const reset =()=> {
  data.courseName = ""
  data.studentName = ""
  data.teacher = ""
  load()
}
const del =(id)=>{
  ElMessageBox.confirm('删除数据后无法回复，您确认删除吗？','删除确认',{type:'warning'}).then(res=> {
    request.delete('/grade/delete/' + id).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success("删除成功")
      } else {
        ElMessage.error(res.msg)
      }
    })
  }) .catch(res => {})
}
const handleEdit =(row) =>
{
  data.form=JSON.parse(JSON.stringify(row))
  data.form.teacher=data.user.name
  data.formVisible=true
}

const save=()=>{
  request.put("/grade/update",data.form).then(res=>{
    if (res.code === '200') {
      load()
    data.formVisible = false;
    ElMessage.success("编辑成功")
  } else {
    ElMessage.error(res.msg)
  }
  })
}
const sort = (order) => {
    // 检查数组中每个元素是否都有 'score' 属性
  if (!data.tableData.every(item => 'score' in item)) {
    ElMessage.warning('请先确保所有数据项都有成绩字段');
    return;
  }

  // 根据 'score' 属性排序
  data.tableData.sort((a, b) => {
    if (order === 'asc') {
      return a.score - b.score; // 升序
    } else {
      return b.score - a.score; // 降序
    }
  });
}

</script>

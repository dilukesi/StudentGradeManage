<template>
  <div>
    <div class="card" style="margin-bottom:18px ">
      <el-input v-model="data.name" style="width: 280px;margin-right: 10px" placeholder="请输入课程名称查询" :prefix-icon="Search"/>
      <el-input v-model="data.no" style="width: 280px;margin-right: 10px" placeholder="请输入课程编号查询" :prefix-icon="Search"/>
      <el-input v-model="data.teacher" style="width: 280px;margin-right: 10px" placeholder="请输入任教老师查询" :prefix-icon="Search"/>
      <el-button type="primary" round style="margin-left: 10px"  @click="load">查询</el-button>
      <el-button type="info" round style="margin-left: 10px " @click="reset">重置</el-button>
    </div>
  </div>
  <div class="card " style="margin-bottom:18px;">
    <div>
      <el-table :data="data.tableData" style="width: 100%">
        <el-table-column prop="id" label="序号" width="100" />
        <el-table-column prop="name" label="课程名"  />
        <el-table-column prop="no" label="课程编号" />
        <el-table-column prop="descr" label="课程描述"  />
        <el-table-column prop="times" label="课时" />
        <el-table-column prop="teacher" label="任教老师"/>
        <el-table-column label="操作" width="180">
        <template #default="scope">
          <el-button type="primary" @click="selectCourse(scope.row)">{{ buttonText }}</el-button>
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
</template>

<script setup>
import { reactive} from "vue";
import { ref } from "vue";
import { Search } from '@element-plus/icons-vue'
import request from "@/utils/request";
import {ElMessage, ElMessageBox} from "element-plus";
const  data =reactive({
  name:"",
  no:"",
  teacher:"",
  total:0,
  tableData:[],
  pageNum: 1,//当前页数
  pageSize:10,//每一页的个数
  student :JSON.parse(localStorage.getItem('student-user')||'{}'),
  user :JSON.parse(localStorage.getItem('student-user')||'{}'),
})
const load=() =>{
  request.get("/course/selectPage",{
    params:{
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      no: data.no,
      teacher:data.teacher
    }
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
const reset =()=>{
  data.name = ""
  data.no = ""
  data.teacher = ""
  load()
}

const buttonText = ref(localStorage.getItem(`buttonText-${data.user.id}`) || '选课');
const selectCourse=(row)=>{
  localStorage.setItem(`buttonText-${data.user.id}`, '已选'); // 将新值保存到 localStorage
  request.post('/studentCourse/add',{studentId: data.student.id , name: row.name, no:row.no, courseId:row.id, teacher:row.teacher,teacherId:data.tableData.teacherId,status:0
  }).then(res=>{
  if (res.code === '200'){
    ElMessage.success("操作成功");

  }else
  {
    ElMessage.error(res.msg)
  }
  })
}

</script>
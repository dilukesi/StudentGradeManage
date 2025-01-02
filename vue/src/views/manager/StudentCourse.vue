<template>
  <div>
    <div class="card" style="margin-bottom:18px ">
      <el-input v-model="data.name" style="width: 280px;margin-right: 10px" placeholder="请输入课程名称查询" :prefix-icon="Search"/>
      <el-input v-model="data.no" style="width: 280px;margin-right: 10px" placeholder="请输入课程编号查询" :prefix-icon="Search"/>
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
        <el-table-column prop="studentName" label="学生名称"/>
        <el-table-column prop="teacher" label="任教老师"/>
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
  user :JSON.parse(localStorage.getItem('student-user')||'{}'),
  gradeForm:{},
  formVisible:false
})
const load=() =>{
  let params={  pageNum: data.pageNum,
    pageSize: data.pageSize,
    name: data.name,
    no: data.no,
  }
  if(data.user.role ==="STUDENT"){
    params.studentId=data.user.id
  }
  if(data.user.role ==="TEACHER"){
    params.TeacherId=data.user.id
  }
  request.get("/studentCourse/selectPage",{
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
const reset =()=>{
  data.name = ""
  data.no = ""
  load()
}
const del =(id)=>{
  ElMessageBox.confirm('删除数据后无法回复，您确认删除吗？','删除确认',{type:'warning'}).then(res=> {
    request.delete('/studentCourse/delete/' + id).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success("删除成功")
      } else {
        ElMessage.error(res.msg)
      }
    })
  }) .catch(res => {})
}

</script>

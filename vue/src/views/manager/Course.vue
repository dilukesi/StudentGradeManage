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
    <el-button type="primary" round @click="handeladd">新增</el-button>
    </div>
    <div>
      <el-table :data="data.tableData" style="width:  100%">
        <el-table-column prop="id" label="序号" width="120" />
        <el-table-column prop="name" label="课程名"  />
        <el-table-column prop="no" label="课程编号"  />
        <el-table-column prop="descr" label="课程描述"  />
        <el-table-column prop="times" label="课时"  />
        <el-table-column prop="teacher" label="任教老师" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button type="primary" size="small" @click="handeledit(scope.row)">编辑</el-button>
            <el-button type="danger" size="small" @click="del(scope.row.id)">删除</el-button>
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

  <el-dialog  width="35%" v-model="data.formVisible" title="课程信息" >
    <el-form :model="data.form" label-width="100px" label-position="right" style="padding-right: 40px">
      <el-form-item label="课程名称" >
        <el-input v-model="data.form.name" autocomplete="off" />
      </el-form-item>
      <el-form-item label="课程编号" >
        <el-input v-model="data.form.no" autocomplete="off" />
      </el-form-item>
      <el-form-item label="课程描述" >
        <el-input v-model="data.form.descr" autocomplete="off" />
      </el-form-item>
      <el-form-item label="课时" >
        <el-input v-model="data.form.times" autocomplete="off" />
      </el-form-item>
      <el-form-item label="任课老师" >
        <el-input v-model="data.form.teacher" autocomplete="off" />
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
  name:"",
  no:"",
  teacher:"",
  total:0,
  tableData:[],
  pageNum: 1,//当前页数
  pageSize:10,//每一页的个数
  formVisible:false,
  form:{}
})
  const load=() =>{
    request.get("/course/selectPage",{
      params:{
        pageNum: data.pageNum,
        pageSize: data.pageSize,
        name: data.name,
        no: data.no,
        teacher: data.teacher
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
  const handeladd =()=>{
    data.form= { }
    data.formVisible=true
  }
  const handeledit =(row)=>{
   data.form=JSON.parse(JSON.stringify(row))
    data.formVisible=true;
  }
  const del =(id)=>{
    ElMessageBox.confirm('删除数据后无法回复，您确认删除吗？','删除确认',{type:'warning'}).then(res=> {
          request.delete('/course/delete/' + id).then(res => {
            if (res.code === '200') {
              load()
              ElMessage.success("删除成功")
            } else {
              ElMessage.error(res.msg)
            }
          })
        }) .catch(res => {})
  }
  //保存数据到后台
  const save =()=>{
    request.request( {
      url:data.form.id ? '/course/update':'course/add',
      method:data.form.id ? 'PUT' : 'POST',
      data:data.form
    }).then(res=>{
      if(res.code ==='200'){
        load()
        data.formVisible=false //弹窗关闭
       ElMessage.success("操作成功")
      }else
      {
        ElMessage.error(res.msg)
      }

    })
  }
</script>
<template>
    <div>
      <div class="card" style="margin-bottom:18px ">
        <el-input v-model="data.username" style="width: 280px;margin-right: 10px" placeholder="请输入教师账号查询" :prefix-icon="Search"/>
        <el-input v-model="data.name" style="width: 280px;margin-right: 10px" placeholder="请输入教师名称查询" :prefix-icon="Search"/>
        <el-button type="primary" round style="margin-left: 10px"  @click="load">查询</el-button>
        <el-button type="info" round style="margin-left: 10px " @click="reset">重置</el-button>
      </div>
    </div>
    <div class="card " style="margin-bottom:18px;">
      <div>
      <el-button type="primary" round @click="handeladd">新增</el-button>
      </div>
      <div>
        <el-table :data="data.tableData" style="width: 100%">
          <el-table-column prop="id" label="工号" width="100" />
          <el-table-column prop="username" label="教师账号" width="140"/>
          <el-table-column prop="name" label="教师姓名" />
          <el-table-column prop="phone" label="教师手机号"  />
          <el-table-column prop="email" label="教师邮箱"  />
          <el-table-column prop="sex" label="性别"/>
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
  
    <el-dialog  width="35%" v-model="data.formVisible" title="教师信息" destroy-on-close>
      <el-form :model="data.form" :rules="rules" ref="formRef" label-width="100px" label-position="right" style="padding-right: 40px" >
        <el-form-item  prop="username" label="教师账号" >
          <el-input v-model="data.form.username" autocomplete="off" />
        </el-form-item>
        <el-form-item prop="password" label="教师密码" >
          <el-input show-password v-model="data.form.password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="教师名称" >
          <el-input v-model="data.form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="手机号" >
          <el-input v-model="data.form.phone" autocomplete="off" />
        </el-form-item>
        <el-form-item label="邮箱" >
          <el-input v-model="data.form.email" autocomplete="off" />
        </el-form-item>
        <el-form-item label="性别" >
          <el-radio-group v-model="data.form.sex">
            <el-radio label="男"></el-radio>
            <el-radio label="女"></el-radio>
          </el-radio-group>
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
  import {reactive,ref} from "vue";
    import { Search } from '@element-plus/icons-vue'
    import request from "@/utils/request";
    import {ElMessage, ElMessageBox} from "element-plus";
  
    const baseurl='/teacher'
  
    const  data =reactive({
    username:"",
    name:"",
    total:0,
    tableData:[],
    pageNum: 1,//当前页数
    pageSize:10,//每一页的个数
    formVisible:false,
    form:{}
  })
  
    const load=() =>{
      request.get(baseurl +"/selectPage",{
        params:{
          pageNum: data.pageNum,
          pageSize: data.pageSize,
          username: data.username,
          name: data.name,
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
        data.username = ""
        data.name = ""
        load()
    }
  
  
  
    const del =(id)=>{
      ElMessageBox.confirm('删除数据后无法回复，您确认删除吗？','删除确认',{type:'warning'}).then(res=> {
            request.delete(baseurl + '/delete/' + id).then(res => {
              if (res.code === '200') {
                load()
                ElMessage.success("删除成功")
              } else {
                ElMessage.error(res.msg)
              }
            })
          }) .catch(res => {})
    }
  
  //表单校验
  const rules = reactive({
    username: [
      { required: true, message: '请输入账号', trigger: 'blur' },
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' },
    ],
  })
  
  const formRef = ref()
  
  const handeladd =()=>{
    data.form= { }
    data.formVisible=true
  }
  
  
  const handeledit =(row)=>{
    data.form=JSON.parse(JSON.stringify(row))
    data.formVisible=true;
  }
  
    //保存数据到后台
  const save =()=>{
      formRef.value.validate((valid) => {
        if(valid){
          request.request( {
            url:data.form.id ? baseurl + '/update': baseurl + '/add',
            method:data.form.id ? 'PUT' : 'POST',
            data:data.form
          }).then(res => {
            if (res.code ==='200'){
              load()
              data.formVisible = false //弹窗关闭
              ElMessage.success("操作成功")
            }else{
              ElMessage.error(res.msg)
            }
          })
        }
      })
    }
  const handleImgUploadSuccess =(res=>{
    data.form.avatar=res.data
  
  })
  
  </script>
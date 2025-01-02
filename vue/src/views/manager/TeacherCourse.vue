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
          <el-table-column prop="studentId" label="学号"/>
          <el-table-column prop="studentName" label="学生名称"/>
          <el-table-column prop="teacher" label="任教老师"/>
          <el-table-column label="操作" width="180">
            <template #default="scope">
               <el-button type="danger" @click="del(scope.row.id)">删除</el-button>
               <el-button 
               :type="getButtonType(scope.row.status)"
                @click="addGrade(scope.row)"
                >{{ getButtonText(scope.row.status) }}</el-button>
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
  
    <el-dialog  width="35%" v-model="data.formVisible" title="打分" >
      <el-form :model="data.gradeForm" label-width="100px" label-position="right" style="padding-right: 40px">
        <el-form-item label="课程名称" >
          <el-input v-model="data.gradeForm.name" autocomplete="off" disabled/>
        </el-form-item>
        <el-form-item label="课程编号" >
          <el-input v-model="data.gradeForm.no" autocomplete="off" disabled/>
        </el-form-item>
        <el-form-item label="平时成绩" prop="lab">
        <el-row>
            <el-col :span="16">
            <el-input v-model="data.Score.day" autocomplete="off" />
            </el-col>
            <el-col :span="8">
            <el-input v-model="data.Score.dayRate" autocomplete="off" placeholder="输入成绩比例" />
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="实验成绩" prop="lab">
        <el-row>
            <el-col :span="16">
            <el-input v-model="data.Score.lab" autocomplete="off" />
            </el-col>
            <el-col :span="8">
            <el-input v-model="data.Score.labRate" autocomplete="off" placeholder="输入成绩比例" />
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="期中成绩" prop="lab">
        <el-row>
            <el-col :span="16">
            <el-input v-model="data.Score.mid" autocomplete="off" />
            </el-col>
            <el-col :span="8">
            <el-input v-model="data.Score.midRate" autocomplete="off" placeholder="输入成绩比例" />
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="期末成绩" prop="lab">
        <el-row>
            <el-col :span="16">
            <el-input v-model="data.Score.final" autocomplete="off" />
            </el-col>
            <el-col :span="8">
            <el-input v-model="data.Score.finalRate" autocomplete="off" placeholder="输入成绩比例" />
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="成绩" >
          <el-input :value="totalScore" autocomplete="off" readobly/>
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
  import { computed } from 'vue';
  import { ref } from 'vue';
  import { Search } from '@element-plus/icons-vue'
  import request from "@/utils/request";
  import {ElMessage, ElMessageBox} from "element-plus";
  const  data =reactive({
    name:"",
    no:"",
    teacherId:"",
    total:0,
    tableData:[],
    pageNum: 1,//当前页数
    pageSize:10,//每一页的个数
    user :JSON.parse(localStorage.getItem('student-user')||'{}'),
    gradeForm:{},
    courseForm:{},
    formVisible:false,
    Score: {
        day: 0,
        dayRate: 0,
        lab: 0,
        labRate: 0,
        mid: 0,
        midRate: 0,
        final: 0,
        finalRate: 0,
  }
  })
  
  const load=() =>{
    let params={  pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      no: data.no,
      teacherId: data.teacherId,
    }
    if(data.user.role ==="TEACHER"){
      params.teacherId=data.user.id
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
  const addGrade =(row) =>
  {
    data.formVisible=true;
    data.gradeForm.name = row.name;
    data.gradeForm.no = row.no;
    data.gradeForm.courseId=row.courseId;
    data.gradeForm.studentId=row.studentId;
    data.gradeForm.teacher=data.user.name;
    data.courseForm.studentId=row.studentId;
    data.courseForm.no = row.no;
  }

  const save=()=>{
    data.gradeForm.score=totalScore;
    request.post("/grade/add",data.gradeForm).then(res=>{
    if (res.code === '200') {
    data.formVisible = false;
      ElMessage.success("打分成功")
    } else {
      ElMessage.error(res.msg)

    }
    })
    request.put("/studentCourse/updateStatus",data.courseForm).then(res=>{
      if (res.code === '200') {
      ElMessage.success("更新状态成功")
    } else {
      ElMessage.error(res.msg)
     
    }
    })
    load()
  }
  const totalScore = computed(() => {
      const { day, dayRate, lab, labRate, mid, midRate, final, finalRate } = data.Score;
      const total = day * (dayRate / 100) + lab * (labRate / 100) + mid * (midRate / 100) + final * (finalRate / 100);
      return total.toFixed(0); // 保留两位小数
    });
  const getButtonText = (status) => {
  if (status === 0) {
    return '评分';
  } else if (status === 1) {
    return '已评分';
  }
  // 可以根据实际情况添加更多状态
  return '';
};

const getButtonType = (status) => {
  if (status === 0) {
    return 'primary';
  } else if (status === 1) {
    return 'danger';
  }
  // 可以根据实际情况添加更多状态
  return '';
};
  
  </script>
  
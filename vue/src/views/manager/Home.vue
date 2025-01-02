<template>
  <div>

    <div class="card" style="line-height: 30px">
      <div>欢迎<span style="color:blue;" v-if="user.role === 'ADMIN'">，管理员：</span>
        <span style="color:blue;" v-if="user.role === 'TEACHER'">，教师：</span>
        <span style="color:blue;" v-if="user.role === 'STUDENT'">，学生：</span>
        <span style="color:blue;">{{user.name}}</span>来到xx大学成绩管理系统！</div>
    </div>

  </div>
</template>

<script setup>
  import request from "@/utils/request";
  const user = JSON.parse(localStorage.getItem('student-user') || '{}')
</script>
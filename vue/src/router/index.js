import {createRouter, createWebHistory} from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Manager',
      component: () => import('@/views/Manager.vue'),
      redirect: '/home',
      children: [
        { path: 'home', name: 'Home', component: () => import('@/views/manager/Home.vue')},
        { path: 'course', name: 'Course', component: () => import('@/views/manager/Course.vue')},
        { path: 'student', name: 'Student', component: () => import('@/views/manager/Student.vue')},
        { path: 'studentperson', name: 'SPerson', component: () => import('@/views/manager/StudentPerson.vue')},
        { path: 'courseList', name: 'CourseList', component: () => import('@/views/manager/CourseList.vue')},
        { path: 'studentCourse', name: 'StudentCourse', component: () => import('@/views/manager/StudentCourse.vue')},
        { path: 'grade', name: 'Grade', component: () => import('@/views/manager/Grade.vue')},
        { path: 'teacher', name: 'Teacher', component: () => import('@/views/manager/Teacher.vue')},
        { path: 'teachercourse', name: 'TeacherCourse', component: () => import('@/views/manager/TeacherCourse.vue')},
        { path: 'teacherperson', name: 'TPerson', component: () => import('@/views/manager/TeacherPerson.vue')},
      ]
    },
    {path: '/login', name: 'Login', component: () => import('@/views/Login.vue'),},
    {path: '/register', name: 'Register', component: () => import('@/views/Register.vue'),}
  ]
})

export default router

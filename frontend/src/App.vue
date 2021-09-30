<template>
  <Form @search="search" />
  <Chart />
</template>

<script setup>
import Form from './components/Form.vue'
import Chart from './components/Chart.vue'

const search = ({query, after, before}) => {
  console.log('load results called', query, after, before)
  fetch(`/results?query=${query}&after=${after}&before=${before}&interval=1d`)
    .then(d => console.log(d.json()))
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

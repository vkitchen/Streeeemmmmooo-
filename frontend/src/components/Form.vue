<template>
  <input
    type="text"
    bg="gray-700"
    text="sm white"
    border="2 rounded"
    v-model="query"
  >
  <Datepicker v-model="after" />
  <Datepicker v-model="before" />
  <select v-model="interval">
    <option value="1h">1 Hour</option>
    <option value="1d">1 Day</option>
    <option value="1w">1 Week</option>
    <option value="1m">1 Month</option>
  </select>
  <button
      bg="blue-400 hover:blue-500 dark:blue-500 dark:hover:blue-600"
      text="sm white"
      font="mono light"
      p="y-2 x-4"
      border="2 rounded blue-200"
      @click="search()"
  >
    Search
  </button>
</template>

<script setup>
import { ref } from 'vue'
import Datepicker from 'vue3-datepicker'
import fromUnixTime from 'date-fns/fromUnixTime'
import getTime from 'date-fns/getTime'

const query = ref('scott morrison');
const after = ref(fromUnixTime(1567173600));
const before = ref(new Date());
const interval = ref('1d');

const emit = defineEmits(['search']);

const search = () => {
  emit('search', {
    query: query.value,
    after: getTime(after.value),
    before: getTime(before.value),
    interval: interval.value,
  });
};
</script>

<style scoped>
</style>

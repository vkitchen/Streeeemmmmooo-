<template>
  <Form @search="search" />
  <VChart class="chart" :option="option" />
</template>

<script setup>
import { ref, computed } from 'vue'
import { use } from "echarts/core";
import { CanvasRenderer } from "echarts/renderers";
import { BarChart } from "echarts/charts";
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
} from "echarts/components";
import VChart from "vue-echarts";
import format from 'date-fns/format'
import Form from './components/Form.vue'

const aggs = ref();

// readability > dry
const xAxis = a => a ? a.first_agg.buckets.map(b => format(b.key, 'yyyy-MM-dd')) : [];
const radio = a => a ? a.first_agg.buckets.map(b => b.second_agg.buckets.find(e => e.key === 'Radio')?.doc_count ?? 0) : [];
const tv = a => a ? a.first_agg.buckets.map(b => b.second_agg.buckets.find(e => e.key === 'TV')?.doc_count ?? 0) : [];
const online = a => a ? a.first_agg.buckets.map(b => b.second_agg.buckets.find(e => e.key === 'Online')?.doc_count ?? 0) : [];
const print = a => a ? a.first_agg.buckets.map(b => b.second_agg.buckets.find(e => e.key === 'Print')?.doc_count ?? 0) : [];
const social = a => a ? a.first_agg.buckets.map(b => b.second_agg.buckets.find(e => e.key === 'Social')?.doc_count ?? 0) : [];

use([
  CanvasRenderer,
  BarChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
]);

const option = computed(() => ({
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'shadow'
    }
  },
  legend: {
    orient: 'vertical',
    right: 10,
    top: 'center'
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  xAxis: {
    type: 'category',
    data: xAxis(aggs.value),
    name: 'Timestamp per period',
    nameLocation: 'middle',
    nameGap: 20
  },
  yAxis: {
    type: 'value',
    name: 'Count of records',
    nameLocation: 'middle',
    nameGap: 50
  },
  series: [
    {
      name: 'Radio',
      type: 'bar',
      stack: 'Medium',
      emphasis: {
        focus: 'series'
      },
      data: radio(aggs.value)
    },
    {
      name: 'TV',
      type: 'bar',
      stack: 'Medium',
      emphasis: {
        focus: 'series'
      },
      data: tv(aggs.value)
    },
    {
      name: 'Online',
      type: 'bar',
      stack: 'Medium',
      emphasis: {
        focus: 'series'
      },
      data: online(aggs.value)
    },
    {
      name: 'Print',
      type: 'bar',
      stack: 'Medium',
      emphasis: {
        focus: 'series'
      },
      data: print(aggs.value)
    },
    {
      name: 'Social',
      type: 'bar',
      stack: 'Medium',
      emphasis: {
        focus: 'series'
      },
      data: social(aggs.value)
    },
  ]
}));

const search = ({query, after, before, interval}) => {
  fetch(`/results?query=${query}&after=${after}&before=${before}&interval=${interval}`)
    .then(data => data.json())
    .then(d => {
      aggs.value = d.aggregations;
    })
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
.chart {
  height: 400px;
}
</style>

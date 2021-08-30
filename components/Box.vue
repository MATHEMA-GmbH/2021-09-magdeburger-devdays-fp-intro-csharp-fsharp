<!--

Simple Box

Example usage:

<box x="100" y="140" width="100" height="50" color="green" borderwidth="3" />

Fallback color: red
Fallback borderwidth: 3

-->

<script setup lang="ts">

defineProps<{
  x: number | string
  y: number | string
  width: number | string
  height: number | string
  borderwidth?: number | string
  color?: string
}>()

</script>

<template>
  <svg
    class="absolute left-0 top-0 pointer-events-none"
    :width="width + 50"
    :height="height + 50"
  >
    <rect
        :x="x"
        :y="y"
        :width="width" 
        :height="height"
        :stroke="color || 'red'" 
        :stroke-width="borderwidth || 3"
        style="fill-opacity:0" />
  </svg>
</template>

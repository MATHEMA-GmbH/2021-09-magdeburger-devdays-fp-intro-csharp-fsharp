<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps({
  image: {
    type: String
  },
  caption: {
      type: String
  },
  height: {
    type: String
  }
})
</script>


<template>
    <figure>
        <img :src="props.image" v-bind:style="{ height: props.height }" />
        <figcaption style="font-size: x-small; font-style: italic;">{{ props.caption }}</figcaption>
    </figure>
</template>

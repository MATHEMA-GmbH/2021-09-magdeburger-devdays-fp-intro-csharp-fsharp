<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps({
  image: {
    type: String
  },
  caption: {
      type: String
  }
})
</script>

<template>
    <figure>
        <img :src="props.image" style="height: 28rem;" />
        <figcaption style="font-size: small">{{ props.caption }}</figcaption>
    </figure>
</template>

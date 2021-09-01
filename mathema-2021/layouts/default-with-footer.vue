<template>
  <div class="slidev-layout default-with-footer">
    <div class="my-auto w-full">
      <slot />
      <div class="w-w-10/12 fixed bottom-0 flex justify-between mb-2 text-sm">
        <span>{{ $slidev.configs.occasion }} </span>
        <span v-if="$slidev.configs.presenter">{{ $slidev.configs.company }} - {{ $slidev.configs.presenter }} - {{ $slidev.configs.contact }}</span>
        <span v-else>{{ $slidev.configs.company }} - {{ $slidev.configs.contact }}</span>
        <span><SlideCurrentNo /> / <SlidesTotal /></span>
        </div>
    </div>
  </div>
</template>

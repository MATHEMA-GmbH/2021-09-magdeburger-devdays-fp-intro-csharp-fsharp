<template>
  <div class="slidev-layout cover">
    <div class="my-auto w-full">
      <slot />
    </div>

<div class="mx-auto mt-7 flex">
    <img src="/img/mathema-logo.svg" alt="Mathema Logo"  />
    <img :src="$slidev.configs.occasionLogoUrl" alt="Occassion Logo" class="ml-7 w-50 object-fit-contain" />
</div>

    <div class="gray-triangle"></div>
    <div class="red-triangle"></div>

  </div>
</template>

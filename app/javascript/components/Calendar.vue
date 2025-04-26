<template>
  <div class="vuetify-scope">
    <v-calendar
        ref="calendar"
        :model-value="[new Date()]"
        :weekdays="[0, 1, 2, 3, 4, 5, 6]"
        color="primary"
    />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { VCalendar } from 'vuetify/labs/VCalendar'

onMounted(async () => {
  await import('../../assets/stylesheets/calendar-vuetify.css') // optional custom styling
})
</script>

<style scoped>
.vuetify-scope {
  max-width: 100%;
  padding: 1rem;
}
</style>

<style>
.vuetify-scope {
  all: initial;
  display: block;
  font-family: 'Roboto', sans-serif;
}

.vuetify-scope *,
.vuetify-scope *::before,
.vuetify-scope *::after {
  all: unset;
  font-family: inherit;
  box-sizing: border-box;
  display: revert;
}
</style>

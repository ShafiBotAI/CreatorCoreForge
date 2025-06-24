<template>
  <div class="chapter-editor" @scroll="onScroll">
    <div
      v-for="chapter in visibleChapters"
      :key="chapter.id"
      class="chapter"
    >
      <textarea v-model="chapter.text" @input="onEdit(chapter)" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from 'vue';

export interface Chapter {
  id: number;
  text: string;
}

export default defineComponent({
  name: 'ChapterEditor',
  props: {
    chapters: {
      type: Array as () => Chapter[],
      required: true
    }
  },
  setup(props) {
    const start = ref(0);
    const size = 20;
    const visibleChapters = ref(props.chapters.slice(0, size));

    function onScroll(e: Event) {
      const target = e.target as HTMLElement;
      start.value = Math.floor(target.scrollTop / 100);
      visibleChapters.value = props.chapters.slice(start.value, start.value + size);
    }

    function onEdit(_chapter: Chapter) {
      // Debounce or emit save events here
    }

    watch(
      () => props.chapters,
      () => {
        visibleChapters.value = props.chapters.slice(start.value, start.value + size);
      }
    );

    return { visibleChapters, onScroll, onEdit };
  }
});
</script>

<style scoped>
.chapter {
  margin-bottom: 1rem;
}
</style>

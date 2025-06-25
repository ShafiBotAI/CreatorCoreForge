<template>
  <div class="chapter-editor" @scroll="onScroll">
    <ChapterItem
      v-for="chapter in visibleChapters"
      :key="chapter.id"
      :chapter="chapter"
      :onEdit="onEdit"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch, computed } from 'vue';
import ChapterItem from './components/ChapterItem.vue';
import { debounce } from './utils/debounce';

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
    const visibleChapters = computed(() =>
      props.chapters.slice(start.value, start.value + size)
    );

    function onScroll(e: Event) {
      const target = e.target as HTMLElement;
      start.value = Math.floor(target.scrollTop / 100);
    }

    const emitEdit = debounce((chapter: Chapter) => {
      // placeholder for emit or API save
    }, 300);

    function onEdit(chapter: Chapter) {
      emitEdit(chapter);
    }

    watch(
      () => props.chapters,
      () => {
        if (start.value + size > props.chapters.length) {
          start.value = Math.max(0, props.chapters.length - size);
        }
      }
    );

    return { visibleChapters, onScroll, onEdit, ChapterItem };
  }
});
</script>

<style scoped>
.chapter-editor {
  overflow-y: auto;
  max-height: 600px;
}
</style>

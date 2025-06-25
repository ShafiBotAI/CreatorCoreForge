<template>
  <div class="chapter-item">
    <textarea v-model="chapter.text" @input="onInput" />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { debounce } from '../utils/debounce';
import type { Chapter } from '../ChapterEditor.vue';

export default defineComponent({
  name: 'ChapterItem',
  props: {
    chapter: {
      type: Object as () => Chapter,
      required: true
    },
    onEdit: {
      type: Function as () => (chapter: Chapter) => void,
      required: true
    }
  },
  setup(props) {
    const emitEdit = debounce(() => props.onEdit(props.chapter), 300);
    function onInput() {
      emitEdit();
    }
    return { onInput };
  }
});
</script>

<style scoped>
.chapter-item {
  margin-bottom: 1rem;
}
</style>

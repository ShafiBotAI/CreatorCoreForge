import { EventEmitter } from 'events';

export class PlaybackEngine extends EventEmitter {
  private position = 0;
  private rate = 1;

  play() {
    this.emit('play');
  }

  pause() {
    this.emit('pause');
  }

  seek(ms: number) {
    this.position = ms;
    this.emit('seek', ms);
  }

  setRate(r: number) {
    this.rate = r;
    this.emit('rate', r);
  }
}

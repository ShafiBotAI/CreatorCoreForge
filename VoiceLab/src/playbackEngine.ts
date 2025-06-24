import { EventEmitter } from 'events';

export class PlaybackEngine extends EventEmitter {
  private position = 0;
  private rate = 1;
  private playing = false;

  play() {
    this.playing = true;
    this.emit('play');
  }

  pause() {
    this.playing = false;
    this.emit('pause');
  }

  stop() {
    this.playing = false;
    this.position = 0;
    this.emit('stop');
  }

  seek(ms: number) {
    this.position = ms;
    this.emit('seek', ms);
  }

  setSpeed(r: number) {
    this.rate = r;
    this.emit('rate', r);
  }

  // backward compatibility
  setRate(r: number) {
    this.setSpeed(r);
  }
}

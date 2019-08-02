import { TestBed, async } from '@angular/core/testing';
import { LogComponent } from './log.component';

describe('LogComponent', () => {
  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [
        LogComponent
      ],
    }).compileComponents();
  }));

  it('should create the app', () => {
    const fixture = TestBed.createComponent(LogComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have as title 'js-web-ui'`, () => {
    const fixture = TestBed.createComponent(LogComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app.title).toEqual('js-web-ui');
  });

  it('should render title in a h1 tag', () => {
    const fixture = TestBed.createComponent(LogComponent);
    fixture.detectChanges();
    const compiled = fixture.debugElement.nativeElement;
    expect(compiled.querySelector('h1').textContent).toContain('Welcome to js-web-ui!');
  });
});

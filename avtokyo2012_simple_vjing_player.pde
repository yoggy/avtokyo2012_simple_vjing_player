//
// avtokyo2012_simple_vjing_player.pde
//
// 2012/11/17 @yoggy
//
import java.io.*;
import processing.video.*; 

// fullscreen http://www.superduper.org/processing/fullscreen_api/
import fullscreen.*; 

String contents_dir = "/Users/yoggy/Documents/Processing/avtokyo2012_vj_contents/data/";

int window_x = 100;
int window_y = 0;
int window_w = 800;
int window_h = 600;

String [] filenames;
Movie [] movies;
Movie current_movie;
PFont font;
FullScreen fs;

void setupMovies() {
  // read movie filenames
  File dir = new File(contents_dir);
  String[] fs = dir.list();
  if (fs != null) {
    filenames = new String[fs.length];
    for(int i = 0; i < fs.length; i++) {
      println(fs[i]);
      filenames[i] = fs[i];
    }
  }

  // create movie instances
  movies = new Movie[fs.length];
  for (int i = 0; i < filenames.length; ++i) {
    movies[i] = new Movie(this, filenames[i]);
  }
}

void setup() {
  size(window_w, window_h);
  frameRate(30);
  
  fs = new FullScreen(this); 
  fs.enter(); 
  noCursor();
  
  font = createFont("Impact", 64, true);
  
  setupMovies();
  playMovie(0);
}

void randomPlayMovie() {
  int idx = (int)random(movies.length);
  playMovie(idx);
}

void playMovie(int idx) {
  if (idx < 0 || movies.length <= idx) return ;
  
  if (current_movie != null) {
    current_movie.stop();
  }
  
  current_movie = movies[idx];
  current_movie.jump(0);
  current_movie.loop();  
}

void draw_text(String msg, int x, int y, color c) {
  textFont(font);
  fill(0, 0, 0);
  for (int dy = -2; dy <= 2; ++dy) {
    for (int dx = -2; dx <= 2; ++dx) {
      text(msg, x + dx, y + dy);
    }
  }
  fill(c);
  text(msg, x, y);
}

void draw() {
  if (current_movie != null) {
    image(current_movie, 0, 0, window_w, window_h);
  }

  draw_text("AVTokyo2012", width - 380, height - 60, color(255,255,255));
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  randomPlayMovie();
}


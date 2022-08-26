
import java.io.*;

final String CFG_FILENAME = "settings.json";

final boolean defaultFullsc = false;
final int defaultWidth = 800, defaultHeight = 600;
final int defaultParticles = 1000;

boolean configFullsc;
int configWidth, configHeight;
int numParticles;

float lastTime;

Particle[] particles;

void settings()
{
  parseSettings();
  size(configWidth, configHeight);
  if (configFullsc)
    fullScreen();
  // todo: framerate
}

void setup()
{
  colorMode(HSB, TWO_PI, 1.f, 1.f, 1.f);
  
  lastTime = millis();
  particles = new Particle[numParticles];
  for (int i = 0; i < particles.length/2; i++)
  {
    particles[i] = new RepelParticle();
  }
  for (int i = particles.length/2; i < particles.length; i++)
  {
    particles[i] = new AttractParticle();
  }
  
  background(0.f, 0.f, 0.f);
}

void parseSettings()
{
  JSONObject cfg = loadJSONObject(CFG_FILENAME);
  configFullsc = cfg.getBoolean("fullscreen", defaultFullsc);
  configWidth = cfg.getInt("width", defaultWidth);
  configHeight = cfg.getInt("height", defaultHeight);
  numParticles = cfg.getInt("particles", defaultParticles);
} //<>//
 //<>//
void draw()
{
  clear();
  float currTime = millis();
  float elapsed = currTime - lastTime;
  lastTime = currTime;
  cursor(CROSS);
  
  for (Particle p : particles)
  {
    p.update(elapsed);
    p.draw(elapsed);
  }
}

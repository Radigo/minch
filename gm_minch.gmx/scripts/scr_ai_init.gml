/** All basic variables used to handle baddies AI */

// Init position
self.initX = x;
self.initY = y;

self.ticker = 0;// Ticker increments itself at each frame
self.tickerLimit = 1000;
self.patternTicker = 0;// Pattern ticker incremented with general ticker
self.patternTickerLimit = 10000;
self.hp = 1;// When HPs are <= 0 then boom
self.shield = false;// Enemy is invincible

self.isActive = false;// Moves and fires when active only
                        // (activation rules at each enemy discretion)
self.switchTriggered = false;// Turn true when enemy is activated by something (switch)

// Scoring
self.color = 0;
self.value = 100;

// Swag
self.explosionSize = 16;// Set the size of the area of particles burst
self.explosionLevel = 2;// Set witch particles has to be sent

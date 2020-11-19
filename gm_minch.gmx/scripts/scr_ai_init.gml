/** All basic variables used to handle baddies AI */

// Init position
self.initX = x;
self.initY = y;
self.followConveyors = true;
self.conveyorMoveX = 0;
self.conveyorMoveY = 0;

self.ticker = 0;// Ticker increments itself at each frame
self.tickerLimit = 1000;
self.patternTicker = 0;// Pattern ticker incremented with general ticker
self.patternTickerLimit = 10000;
self.hp = 1;// When HPs are <= 0 then boom
self.shield = false;// Enemy is invincible
self.noCollision = false;// Enemy doesn't collide with MinCH
self.lastHitTicker = -1;

self.isActive = false;// Moves and fires when active only
                        // (activation rules at each enemy discretion)
self.switchTriggered = false;// Turn true when enemy is activated by something (switch)

self.safeZone = 8;// Outbounds distance until enemies can be hit

// Scoring
var str = object_get_name(self.id.object_index);
// Get the last 2 characters of the object name to set color
var str_color = string_char_at(str, (string_length(str) - 1)) + string_char_at(str, (string_length(str) - 0));
    
self.color = scr_colors_str_to_int(str_color);
self.value = 100;

// Swag
self.explosionSize = 16;// Set the size of the area of particles burst
self.explosionLevel = 2;// Set witch particles has to be sent

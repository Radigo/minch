var bullet = other;

var pushDirectionRad = arctan2((self.y - bullet.y), (bullet.x - self.x));
var pushDirectionDeg = pushDirectionRad / pi * 180;

bullet.direction = pushDirectionDeg;
var speedRatio = self.ticker / self.tickerLimit;
bullet.speed = speedRatio * 1.5;

/*
Notices something
Looks down and wait
Wall explodes, light come in, particles
-> End level appears at wall hole position
Nuke fly from bottom to CH1
CH1 explodes at Nuke's contact (MinCH too btw...)
-- End of CH1 life, cinematic continues on Nuke side


Nuke stops, look right and wait a short time
Nuke escapes back through the wall
*/

if (instance_exists(obj_grenwave) && place_meeting(self.x, self.y, obj_grenwave)) {
    // Boom
    scr_boom(self.x, self.y, 4, 24);
    with (self)
        instance_destroy();
    return false;
}

// Notices something
if (self.ticker == 5) {
    // display '!'
} else if (self.ticker == 60) {
    // Bullet cancel all
    scr_all_bullet_cancel();
    // Destroy all pods if any
    var i;
    for (i = 0; i < instance_number(obj_pod); i += 1)
    {
        pod = instance_find(obj_pod, i);
        scr_boom(pod.x, pod.y, 1, 8);
    }
    
    instance_destroy(obj_pod);

    var tile;
    var tileSize = 32;
    var centerTileX = floor(self.x / tileSize) * tileSize;
    var topTileY = 608;
    var bottomTileY = 864;
    
    // Display hole by changing tiles in BG
    tile = tile_layer_find(1000000, centerTileX - tileSize, bottomTileY);
    tile_set_region(tile, 64, 128, tileSize, tileSize);
    tile = tile_layer_find(1000000, centerTileX, bottomTileY);
    tile_set_region(tile, 64, 96, tileSize, tileSize);
    tile = tile_layer_find(1000000, centerTileX + tileSize, bottomTileY);
    tile_set_region(tile, 96, 128, tileSize, tileSize);
    // Delete tiles in shading layer
    for (var tileX = self.x - tileSize; tileX <= self.x + tileSize; tileX += tileSize) {
        for (var tileY = 608; tileY <= 864; tileY += tileSize) {
             tile = tile_layer_find(-100, tileX, tileY);
             tile_delete(tile);
        }
    }
    // Cut a hole in the wall logic
    var wall = instance_position(centerTileX, bottomTileY, obj_wall);
    var wallSize = wall.sprite_width;
    with (wall)
        instance_destroy();
    
    var wallLeft = instance_create(0, bottomTileY, obj_wall);
    wallLeft.image_xscale = centerTileX / tileSize;
    var wallRight = instance_create((centerTileX + tileSize), bottomTileY, obj_wall);
    wallRight.image_xscale = (wallSize - centerTileX + centerTileX) / tileSize;
    
    // Create end area
    instance_create(centerTileX, bottomTileY, obj_area_end_level);
    
    // Display booms
    scr_boom((centerTileX - (tileSize * 0.5)), (bottomTileY + (tileSize * 0.5)), 3, 32);
    scr_boom((centerTileX + (tileSize * 1.5)), (bottomTileY + (tileSize * 0.5)), 3, 32);
    scr_boom((centerTileX + (tileSize * 0.5)), (bottomTileY + (tileSize * 0.5)), 4, 32);
    
    // spawn Nuke
    instance_create(centerTileX, bottomTileY, obj_nuke);
    
    // Stop BGM
    global.nextBGM = bgm_stop;
    global.bgmSequencing = global.BGM_SEQUENCE_INSTANT;
    audio_stop_sound(global.currentBGM);
    scr_play_bgm();
} else if (self.ticker == self.tickerLimit) {
    // stop everything to avoid looping
    with (self)
        instance_destroy();
    return false;
}

self.legs.sprite_index = spr_ch1_legs_idle;
self.sprite_index = spr_ch1_body_lookdown;

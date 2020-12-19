var newScore = argument0;
var levelStr = argument1;
var isNewScore = argument2;

if (isNewScore) {
    var previousScore = ds_map_find_value(global.scoreAttackScores, levelStr);

    if ((previousScore != undefined) && (newScore < previousScore)) {
        return false;
    }
    
    ds_list_add(global.newScoreAttackHighScoreLevels, levelStr);
}

ds_map_delete(global.scoreAttackScores, levelStr);// Make room for data
ds_map_add(global.scoreAttackScores, levelStr, newScore);

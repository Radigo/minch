var newScore = argument0;
var isNewScore = argument1;

// add
ds_list_add(global.normalGameScores, newScore);
// Sort
ds_list_sort(global.normalGameScores, false);

// Cleanup
while (ds_list_size(global.normalGameScores) > 10) {
    ds_list_delete(global.normalGameScores, ds_list_size(global.normalGameScores) - 1);
}

if (isNewScore) {
    var newIndex = ds_list_find_index(global.normalGameScores, newScore);
    
    if ((newIndex >= 0) && (newIndex < 10)) {
        global.newNormalGameHighScoreIndex = newIndex;
    }
}

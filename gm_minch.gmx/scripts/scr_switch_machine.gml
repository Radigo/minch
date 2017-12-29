// Manage communications between switches and objects supposed to recieve actions
var action_id = argument0;

show_debug_message("Activated switch id:" + string(action_id));

// Following woks with only 1 object
if (ds_map_exists(global.actions_map, action_id))
{
    var dynamic_objects_list = ds_map_find_value(global.actions_map, action_id);
    var action_rule = ds_map_find_value(global.rules_map, action_id);
    
    for (var i = 0; i < ds_list_size(dynamic_objects_list); i++)
    {
        var dynamic_object = ds_list_find_value(dynamic_objects_list, i);
        
        with (dynamic_object)
        {
            //show_debug_message("scr_switch_machine > action_id:" + dynamic_object.action_id + ", rule: " + dynamic_object.action_rule);
            show_debug_message("scr_switch_machine > rule: " + action_rule);
            
            switch (action_rule)
            {
                case global.ENEMY_TRIGGER_ON:
                    dynamic_object.switchTriggered = true;
                    break;
                case global.ENEMY_TRIGGER_OFF:
                    dynamic_object.switchTriggered = false;
                    break;
                case global.START_CINEMATIC:
                    dynamic_object.timeline_running = 1;
                    break;
                case global.CAMERA_FOCUS_BOSS_ON:
                    if (dynamic_object.isActive == false)
                    {
                        break;
                    }
                    
                case global.CAMERA_FOCUS_ENEMY_ON:
                    // Only if focus object is MinCH (no focus) OR focus changed
                    
                    if (obj_minch_camera.focus == obj_minch
                        || (object_get_name(obj_minch_camera.focus) != object_get_name(dynamic_object)))
                    {
                        obj_minch_camera.transitionDuration = obj_minch_camera.transitionInDuration;
                        obj_minch_camera.transitionStep = obj_minch_camera.transitionInDuration;
                        obj_minch_camera.focus = dynamic_object;
                    }
                    break;
                    
                case global.CAMERA_FOCUS_ENEMY_OFF:
                    obj_minch_camera.transitionDuration = obj_minch_camera.transitionOutDuration;
                    obj_minch_camera.transitionStep = obj_minch_camera.transitionOutDuration;
                    obj_minch_camera.focus = obj_minch;
                    break;
                    
                case global.DOOR_OPEN:
                case global.DOOR_CLOSE:
                    scr_add_door_anim_object(action_rule, dynamic_object);
                    scr_change_door_triggered_instance(action_rule, dynamic_object);
                    break;
                
                case global.CREATE_PLATFORM:
                    var platform_instance = instance_create(dynamic_object.x, dynamic_object.y, obj_platform);
                    platform_instance.depth = 100;
                    platform_instance.image_speed = 1;
                    with (dynamic_object) instance_destroy();
                    break;
                    
                case global.CHANGE_STATUS_ACTIVE:
                    with (dynamic_object) self.status = "active";
                    break;
                
                case global.CHANGE_STATUS_INACTIVE:
                    with (dynamic_object) self.status = "inactive";
                    break;
                    
                case global.TELEPORT_PLAYER_TO:
                     //show_debug_message("teleport to: " + string(dynamic_object.x) + ":" + string(dynamic_object.y) + "@ " + string(obj_minch.mainAngle));
                     obj_minch.x = dynamic_object.x + (cos(obj_minch.mainAngle) * 2);
                     obj_minch.y = dynamic_object.y + (sin(obj_minch.mainAngle) * 2);
                     break;
                 
                default:
                    dynamic_object.image_index = 1;
                    break;
            }
        }
    }
}

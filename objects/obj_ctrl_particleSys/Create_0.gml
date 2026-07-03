global.partSystem = part_system_create();
part_system_position(global.partSystem, 0, 0);

//Fireball particles
global.partTypeFireballTrail = part_type_create();
part_type_sprite(global.partTypeFireballTrail, spr_bgprt_hex, false, true, false)
part_type_size(global.partTypeFireballTrail, 1.5, 2, -0.08, 0.03);
part_type_scale(global.partTypeFireballTrail, 0.2, 0.2);
part_type_direction(global.partTypeFireballTrail, 0, 0, 0, 10);
part_type_gravity(global.partTypeFireballTrail, 0, 90);
part_type_orientation(global.partTypeFireballTrail, 0, 360, 0, 0, true);
part_type_colour3(global.partTypeFireballTrail, $0000FF, $0065FF, $00FFFF);
part_type_alpha3(global.partTypeFireballTrail, 1, 1, 1);
part_type_blend(global.partTypeFireballTrail, true);
part_type_life(global.partTypeFireballTrail, 20, 20);

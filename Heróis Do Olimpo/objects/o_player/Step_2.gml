var _depth = (aim_dir > 0 and aim_dir < 180);
my_weapon.depth = depth + _depth;

my_weapon.x = x + lengthdir_x(weapon_dis, aim_dir);
my_weapon.y = y + lengthdir_y(weapon_dis, aim_dir);
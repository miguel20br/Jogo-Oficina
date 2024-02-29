//coloca todas as variáveis em 0
function reset_variables() {
	left = 0;
	right = 0;
	up = 0;
	down = 0;
	vmove = 0;
	hmove = 0;
}

//checa se as teclas "WASD" estão sendo apertadas
function get_input() {
	if keyboard_check(ord("A")) left = 1;
	if keyboard_check(ord("D")) right = 1;
	if keyboard_check(ord("W")) up = 1;
	if keyboard_check(ord("S")) down = 1;
}

function calc_movement() {
	hmove = right - left;
	vmove = down - up;
	
	var _facing = (aim_dir < 90 or aim_dir > 270);
	if _facing == 0 _facing = -1;
	facing = _facing;
	
//if up down left or right estão pressionados
	if hmove != 0 or vmove != 0 { 
		//coletar a direção de movimento
		var _dir = point_direction(0, 0, hmove, vmove);
		
		//coletar a distância que estamos nos movendo
		hmove = lengthdir_x(walk_spd, _dir);
		vmove = lengthdir_y(walk_spd, _dir);
		
		//adicionar movimento para a posição do player
		x += hmove;
		y += vmove;
	}
	
	aim_dir = point_direction(x, y, mouse_x, mouse_y);
	my_weapon.image_angle = aim_dir;
	
}

function collision() {
	//setar os target values
	var _tx = x;
	var _ty = y;
	
	//move para a última posição do step fora da colisão
	x = xprevious;
	y = yprevious;
	
	//pegar a distância que nós queremos nos mover
	var _disx = abs(_tx - x);
	var _disy = abs(_ty - y);
	
	//mover a maior quantidade possível antes de bater em uma parede
	repeat(_disx) {
		if !place_meeting(x + sign(_tx - x), y, o_solid) x += sign(_tx - x);
	}	
	repeat(_disy) {
		if !place_meeting(x, y + sign(_ty - y), o_solid) x += sign(_ty - y);
	}	
}

function anim() {
	if hmove != 0 or vmove != 0 {
		sprite_index = s_player_walk;
	} else {
		sprite_index = s_player_idle;
	}
}
	function NavigationManager:find_cover_in_nav_seg_near_pos(nav_seg_id, defend_pos, max_distance)
		local search_params = {
			near_pos = defend_pos,
			in_nav_seg = nav_seg_id,
			max_distance = max_distance
		}
		return self._quad_field:find_cover(search_params)
	end
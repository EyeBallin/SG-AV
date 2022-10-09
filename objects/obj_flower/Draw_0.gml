for (var i = 0; i < prtCount; i += 1) {
	draw_sprite_ext(spr_flowerPrt, 0, x, y, flowerPrts[i].sizeMult * randSize, flowerPrts[i].sizeMult * randSize,
		flowerPrts[i].currRot + randAngle, flowerPrts[i].colMult, randAlpha);
}
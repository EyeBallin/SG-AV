function dpEnemies(eArr) {
	//Test Enemy
	eArr[enemyIDs.eTest].addEnemyInfoBasic("Test Enemy", entityTypes.eEnemyNormal, "A test enemy. Stands still and has a fucktonne of HP.", 0, 0, -1, 0, [
		new infoEnemyDrawLine(spr_enemy_test, 1, 1, 1, c_white, 1, 30, false, spr_enemy_test)
	]);
	eArr[enemyIDs.eTest].addEnemyInfoStats(100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, elementTypes.eNone);
	eArr[enemyIDs.eTest].enDataCodeDraw = function() {
		var sprData = enemySpriteArr[enemySpriteCurr];
		draw_sprite_ext(sprData.enDrawSpr, sprData.enDrawSprSub, x, y, sprData.enDrawW, sprData.enDrawH,
			image_angle, sprData.enDrawBlend, sprData.enDrawAlpha);
	}
}
//On first step of existence, initialise collision check category
if (auraTimer == 0) {
    if (auraOwner.entityType == entityTypes.ePlayer || auraOwner.entityType == entityTypes.eAlly)
        collCheck = obj_enemy;
    if (auraOwner.entityType == entityTypes.eEnemyBoss || auraOwner.entityType == entityTypes.eEnemyNormal || auraOwner.entityType == entityTypes.eEnemyMinion)
        collCheck = obj_sg_av;
}
auraCodeStep(self);
if (auraAttachObj != -1) {
    x = auraAttachObj.x + auraAttachOffsetX;
    y = auraAttachObj.y + auraAttachOffsetY;
}
auraCollCount = 0;
if (auraTimer mod auraTickInterval == 0) {
    ds_list_clear(auraCollList);
    auraCollCount = collision_circle_list(x, y, auraRadiusNum * auraScale, collCheck, false, true, auraCollList, false);
}
if (auraCollCount > 0) {
    collideAura(self, auraCollList);
}
auraTimer += 1;
auraTimePerc = auraDur == -1 ? 0 : auraTimer/auraDur;
if (auraTimer > auraDur && auraDur != -1) {
    instance_destroy();
}
auraAlphaCurr = 0.5 + (sin(degtorad(auraTimer*6)) * 0.25);
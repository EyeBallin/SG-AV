/// @param {Struct.infoAttackComponent} sourceInfo Attack Info
/// @param {Id.Instance<obj_abs_entity>} owner Owning entity
/// @param {Id.Instance<obj_abs_dmg>} damagingObject The damaging object
function calcDamageScalings(sourceInfo, owner, damagingObject) {
	var dmgScalings = sourceInfo.attCompScaling;
  var scalingVals = variable_struct_get_names(dmgScalings);

  for (var i = 0; i < array_length(scalingVals); i += 1) {
    var scalingKey = scalingVals[i];
    var gotScaling = dmgScalings[$ scalingKey];
		if (gotScaling == 0) {
			continue;
		}
    switch (scalingKey) {
      case "scalePhys":
        damagingObject.dmgVal += owner.getStatDmgPhys().getStatCurr() * gotScaling;
        break;
      case "scaleEner":
        damagingObject.dmgVal += owner.getStatDmgEner().getStatCurr() * gotScaling;
        break;
      case "scaleHPCurr":
        damagingObject.dmgVal += owner.getStatHP().getStatCurr() * gotScaling;
        break;
      case "scaleHPMax":
        damagingObject.dmgVal += owner.getStatHP().eStatCalcMax * gotScaling;
        break;
      case "scaleHPMissing":
        damagingObject.dmgVal += (owner.getStatHP().eStatCalcMax - owner.getStatHP().getStatCurr()) * gotScaling;
        break;
      case "scaleEnemyHPCurr":
        damagingObject.dmgEnemyHPScaleCurr += gotScaling;
        break;
      case "scaleEnemyHPMax":
        damagingObject.dmgEnemyHPScaleMax += gotScaling;
        break;
      case "scaleEnemyHPMissing":
        damagingObject.dmgEnemyHPScaleMissing += gotScaling;
        break;
      case "scaleManaCurr":
        damagingObject.dmgVal += owner.getStatMana().getStatCurr() * gotScaling;
        break;
      case "scaleManaMax":
        damagingObject.dmgVal += owner.getStatMana().eStatCalcMax * gotScaling;
        break;
      case "scaleManaMissing":
        damagingObject.dmgVal += (owner.getStatMana().eStatCalcMax - owner.getStatMana().getStatCurr()) * gotScaling;
        break;
      case "scaleAttSpeed":
        damagingObject.dmgVal += owner.getStatSpdAtt().getStatCurr() * gotScaling;
        break;
    }
  }
}
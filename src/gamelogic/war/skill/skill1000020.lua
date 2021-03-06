--<<skill 导表开始>>
local super = require "gamelogic.war.skill.skill"
cskill1000020 = class("cskill1000020",super,{
	type = 1000020,
	name = "川流不息",
	canuse = 1,
	cd = 2,
	use_max_cnt = -1,
	_use_effect = 4000020,
	_passive_effects = {},
	desc = "对焦点周围$num目标造成$damage点水系伤害",
})

function cskill1000020:init(option)
	super.init(self,option)
--<<skill 导表结束>>

end --导表生成


function cskill1000020:get_targets(focus)
	local caster = self.owner
	local targets = cselector.new(caster:enemys())
						:around(focus)
						:not_die()
						:result()
	local limit = self.use_effect.target_max_num
	targets = self:sort_targets(targets,limit)
	return targets
end

function cskill1000020:do_effect(effect,target,focus)
	local caster = self.owner
	if self.use_effect == effect then
		local damage = {
			type = "water_fs_atk",
		}
		local base_damage = self:base_damage()
		damage.value = base_damage * (1 + caster:getattr("water_fs_atk_addn"))
		local bj = caster:getattr("water_fs_bj")
		if ishit2(bj) then
			damage.value = self:bj_damage(damage.type,damage.value)
			damage.bj = true
		end
		damage.value = math.floor(damage.value)
		target:damage(effect,damage)
	end
end

function cskill1000020:base_damage()
	local caster = self.owner
	return caster.lv * 100
end


return cskill1000020

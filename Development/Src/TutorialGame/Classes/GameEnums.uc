/**
 * 游戏中用到的枚举类
 */
class GameEnums extends Object;

//角色状态
enum GamePawnState {
	PS_None,//默认
	PS_Walk,//行走
	PS_Attack,//攻击
};

//角色动画状态
enum GamePawnAnimState {
	PA_Walk,//移动状态
	PA_Jump,//跳跃
	PA_Talk,//对话
	PA_Attack,//攻击
};

DefaultProperties
{
}

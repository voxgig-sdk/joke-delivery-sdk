package core

type JokeDeliveryError struct {
	IsJokeDeliveryError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewJokeDeliveryError(code string, msg string, ctx *Context) *JokeDeliveryError {
	return &JokeDeliveryError{
		IsJokeDeliveryError: true,
		Sdk:              "JokeDelivery",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *JokeDeliveryError) Error() string {
	return e.Msg
}

extends Node

class_name FSM 

	#private Stack<FSMState> stateStack = new Stack<FSMState>();
var stateStack = [] 

# //so this delegate is cycling between the moveState, performState, and idleState;
#     public delegate void FSMState(FSM fsm, GameObject gameObject);


#     public void Update(GameObject gameObject)
#     {
#         if(stateStack.Peek() != null)
#         {
#             Profiler.BeginSample("Update invocation");

# //this is invoking the delegate at the top of the stack which would change depending on if it were idleState, PerformState or moveToState; Invoke is a delegate method that calls the delegate, so it's basically saying do this method depending on which state is on top 
#             stateStack.Peek().Invoke(this, gameObject);
            
#             Profiler.EndSample();
#         }
#     }

func pushState(state : FSMState) -> void:
        #here we're putting a new state on top
    stateStack.push_front(state);
   
func popState() -> void:
	stateStack.pop_front()



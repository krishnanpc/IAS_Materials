function err=empiricalRisk(YGround,YDash)
err=(YGround==YDash);
err=(~err)*1;
err=mean(err);
end
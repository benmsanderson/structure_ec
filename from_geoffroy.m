function p_out=from_geoffroy(p_in)

  lambda=1./p_in(1);
  gamma_in=p_in(2);
  C=p_in(3);
  C_0_in=p_in(4);
  epsilon=p_in(5);

  gamma=gamma_in*epsilon;
  C_0=C_0_in*epsilon;

  
  t_eq=1./lambda;

  b=(lambda+gamma)/C+gamma/C_0;
  b_star=(lambda+gamma)/C-gamma/C_0;
  delta=b.^2-4*(lambda*gamma)/(C*C_0);
  
  tau_f=C*C_0/(2*lambda*gamma)*(b-sqrt(delta));
  tau_s=C*C_0/(2*lambda*gamma)*(b+sqrt(delta));
  
  psi_f=C/(2*gamma)*(b_star-sqrt(delta));
  psi_s=C/(2*gamma)*(b_star+sqrt(delta));
  
  a_f=psi_s*tau_f/(C*(psi_s-psi_f))*lambda;
  a_s=-psi_f*tau_s/(C*(psi_s-psi_f))*lambda;

  s_f=a_f/lambda;
  s_s=a_s/lambda;


  p_out(1)=s_f;
  p_out(2)=s_s;
  p_out(3)=tau_f;
  p_out(4)=tau_s;
  
end


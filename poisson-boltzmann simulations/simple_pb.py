#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 17 14:31:01 2025

@author: max
"""

import scipy.integrate
import numpy as np
import matplotlib.pyplot as plt

F = 96485
R = 8.3144598
T = 293.15
eps = 8.854187817e-12

z = np.array([2,-2])
C_0 = np.array([1,1])

def pb(x, y):
       phi = y[0]
       dphi_dx = -np.sign(phi)*(2*R*T/eps*np.sum(C_0*(np.exp(-F*z*phi/(R*T))-1)))**0.5
       dy_dx = np.array([dphi_dx])
       return dy_dx


K = (F**2/(eps*R*T)*np.sum(C_0*z**2))**0.5

x_l = 0
x_r = 10/K

# See comment below about the choice of element size
x_mesh = np.linspace(x_l, x_r, 500000)

phi_0s = np.linspace(-0.35,0.35, 1000)

excess_charges_nonlinear = {}
excess_charges_linear = {}

for phi_0 in phi_0s:
    sol = scipy.integrate.solve_ivp(
        pb,
        [x_l, x_r],
        np.array([phi_0]),
        method="BDF",
        # rtol = 1e-10,
        t_eval=x_mesh,
    )

    phi_nonlinear = sol.y[0]
    phi_linear = phi_0*np.exp(-K*x_mesh)

    C_nonlinear = C_0*np.exp(-z*F*np.expand_dims(phi_nonlinear, 1)/(R*T))
    C_linear = C_0*np.exp(-z*F*np.expand_dims(phi_linear, 1)/(R*T))


    excess_charges_nonlinear[phi_0] = scipy.integrate.trapezoid(C_nonlinear-C_0, x=x_mesh, axis=0)
    excess_charges_linear[phi_0] = scipy.integrate.trapezoid(C_linear-C_0, x=x_mesh, axis=0)


excess_charges_nonlinear = np.stack(list(excess_charges_nonlinear.values()), axis=0)
excess_charges_linear = np.stack(list(excess_charges_linear.values()), axis=0)

#%%
a=0.5
excess_charges_approximation = C_0*(np.exp(-z*a*F*np.expand_dims(phi_0s, 1)/(R*T))-1)/(K*a)


total_charge_nonlinear = -F*np.sum(z*excess_charges_nonlinear, axis=1)
total_charge_linear = -F*eps*np.sum(z*excess_charges_linear, axis=1)
total_charge_approximation = -F*np.sum(z*excess_charges_approximation, axis=1)

#%%
plt.figure()
plt.plot(phi_0s, total_charge_nonlinear)
#plt.gca().set_prop_cycle(None)
#plt.plot(phi_0s, total_charge_linear, '--')
plt.gca().set_prop_cycle(None)
plt.plot(phi_0s, total_charge_approximation, ':')

plt.ylim([-0.5, 0.5])

# Our simulation of the theory/reference solution is only accurate up to about 0.2 volts
# because of the chosen mesh size. Things get extremely small with higher voltages.
# A non-uniform mesh size would help, but we just brute force it with half a million elements
plt.xlim([-0.2, 0.2])

plt.ylabel("Total diffuse charge (C/m^2)")
plt.xlabel("Diffuse layer voltage (V)")
plt.legend(["Reference", "Approximation"])


#%%

plt.figure()
for i in range(len(C_0)):
    plt.plot(phi_0s, excess_charges_nonlinear[:,i])

#plt.gca().set_prop_cycle(None)
#plt.plot(phi_0s, excess_charges_linear[:,0], '--')
#plt.plot(phi_0s, excess_charges_linear[:,1], '--')
#plt.plot(phi_0s, excess_charges_linear[:,2], '--')
plt.gca().set_prop_cycle(None)
for i in range(len(C_0)):
    plt.plot(phi_0s, excess_charges_approximation[:,i], ':')

plt.ylim(-0.3e-8,3e-8)
plt.xlim([-0.2, 0.2])
plt.ylabel("Excess species (mol/m^2)")
plt.xlabel("Diffuse layer voltage (V)")

#%%
fig, axes= plt.subplots(2,1)
#plt.clf()
axes[0].plot(sol.t, phi_nonlinear)
axes[0].set_prop_cycle(None)
axes[0].plot(sol.t, phi_linear, '--')

for i in range(len(C_0)):
    axes[1].plot(sol.t, C_nonlinear[:, i])
axes[1].set_prop_cycle(None)
for i in range(len(C_0)):
    axes[1].plot(sol.t, C_linear[:, i], '--')


#print(scipy.integrate.trapezoid(C-C_0, axis=0)/(C[0]-C_0))

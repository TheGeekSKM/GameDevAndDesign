// Inherit the parent event
event_inherited();

///

followCPU = lerp(followCPU, (obj_PCManager.cpu_stock / 50) * 100, 0.05);
followGPU = lerp(followGPU, (obj_PCManager.gpu_stock / 50) * 100, 0.05);
followRAM = lerp(followRAM, (obj_PCManager.ram_stock / 50) * 100, 0.05); // 50 is the max value for ram stock
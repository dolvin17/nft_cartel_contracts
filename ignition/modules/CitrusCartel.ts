import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "ethers";

// const MINT_START = Math.floor(new Date("2025-05-15T00:00:00Z").getTime() / 1000);

const CitrusCartelModule = buildModule("CitrusCartelModule", (m) => {
  const contract = m.contract("CitrusCartel1155")
  return { contract };
});

export default CitrusCartelModule;

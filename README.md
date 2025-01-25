# Entrega Daniel Galán Cortés - Desarrollando Smart Contracts con Solidity en Remix

## ClimateCoin Dapp - Gestor de Créditos de Carbono

### Descripción
ClimateCoin es una Dapp diseñada para gestionar créditos de carbono utilizando tecnología blockchain. Implementa los estándares **ERC-20** y **ERC-721** para permitir la creación, intercambio y quema de tokens digitales que representan proyectos de reducción de emisiones de carbono. 

Básicamente, este sistema promueve la transparencia y trazabilidad en los mercados de créditos de carbono, en este caso en los departamentos que presentan mayor industria y emisiones de carbono, tales como:
**Antioquia, Cundinamarca, Meta, Caquetá, Valle del Cauca y Santander.**

---

### **Características**

1. **Token ERC-20 ClimateCoin**  
   Un token fungible (puede ser intercambiado por otro token del mismo tipo, sin que se altere su valor) llamado **ClimateCoin** que representa créditos de carbono.

2. **NFTs ERC-721**  
   Tokens no fungibles (único, indivisible e irrepetible), que representan proyectos de reducción de emisiones, con detalles como:
   - El nombre del proyecto.
   - La URL.
   - Créditos disponibles.

3. **Intercambio de NFTs por ClimateCoins**  
   Los usuarios pueden intercambiar NFTs por ClimateCoins, con una comisión configurable para el propietario del contrato.

4. **Quema de Tokens**  
   Los usuarios pueden quemar ClimateCoins junto con NFTs para "retirar" créditos de carbono del mercado.

---

### **Requisitos Previos**

- **Remix**: IDE en línea para desarrollar y desplegar contratos inteligentes.
- **Metamask**: Billetera digital para interactuar con la blockchain.
- **Red de prueba Ethereum**: Sepolia o cualquier testnet compatible con Ethereum.

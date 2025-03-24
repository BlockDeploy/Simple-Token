
### Instructions for Using SimpleToken

**Description:**  This is a secure ERC-20 token with pause and burn functions,  
ideal for creating your own digital assets with flexible management.

**Compilation:**  Open the "Deploy Contracts" page in BlockDeploy,  
paste the code into the "Contract Code" field,  
select Solidity version 0.8.0 from the dropdown menu,  
click "Compile" — the "ABI" and "Bytecode" fields will populate automatically.

**Deployment:**  In the "Deploy Contract" section, select the desired network (e.g., Ethereum),  
enter the private key of a wallet with ETH into the "Private Key" field,  
specify the constructor parameters in the table below,  
click "Deploy" and confirm in the modal window.  

# Example


Full name of the token

"My Token"

Symbol

"MTK"

Decimals

18

Initial Supply

1000000

**Usage:**  

-   Send tokens using  `transfer`.
-   Authorize spending with  `approve`.
-   Burn tokens with the  `burn`  function.
-   Manage the contract (owner only):  
    pause operations with  `pause`,  
    resume with  `unpause`.

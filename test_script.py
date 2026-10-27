# Go to line 19, delete the real token, replace with:
# token = os.getenv("ASTRA_TOKEN") 
# or: token = "YOUR_ASTRA_TOKEN_HERE"

# Save: Ctrl+O, Enter, Ctrl+X

# Then fix the last commit
git add test_script.py
git commit --amend --no-edit

# Now push again - this time it will go through
git push -u origin mainimport os
import sys
from astrapy import DataAPIClient
from astrapy.authentication import (
    StaticTokenProvider,
    AWSEmbeddingHeadersProvider,
    RerankingAPIKeyHeaderProvider
)
from astrapy.info import (
    CollectionDefinition, 
    VectorServiceOptions, 
    CollectionRerankOptions, 
    RerankServiceOptions
)

class SupercomputerAgent:
    def __init__(self):
        print("🔧 [Step 1/5] Loading security credentials...")
    self.db_token = os.getenv("ASTRA_DB_TOKEN")
        self.db_url = "https://datastax.com"
        
        self.aws_access_id = os.getenv("AWS_EMBEDDING_ACCESS_ID", "my-access-id")
        self.aws_secret_id = os.getenv("AWS_EMBEDDING_SECRET_ID", "my-secret-id")
        self.rerank_api_key = os.getenv("RERANK_API_KEY", "xyz987...")

        print("🔑 [Step 2/5] Initializing authentication structures...")
        self.token_provider = StaticTokenProvider(self.db_token)
        self.embedding_provider = AWSEmbeddingHeadersProvider(
            embedding_access_id=self.aws_access_id,
            embedding_secret_id=self.aws_secret_id
        )
        self.rerank_provider = RerankingAPIKeyHeaderProvider(self.rerank_api_key)
        
        print("🌐 [Step 3/5] Connecting API client gateway...")
        self.client = DataAPIClient()
        self.db = self.client.get_database(self.db_url, token=self.token_provider, keyspace="default_keyspace")
        print("🤖 Core Agent Authentication Layer Initialized Successfully.")

    def build_super_collection(self, collection_name: str):
        """Creates a collection with integrated AWS Bedrock Embeddings and Reranking."""
        print("📐 Designing collection schemas and cloud vectorize options...")
        vector_opts = VectorServiceOptions(
            provider="bedrock",
            model_name="amazon.titan-embed-text-v1",
        )
        
        rerank_opts = RerankServiceOptions(
            provider="cohere",
            model_name="rerank-english-v3.0",
        )

        definition = (
            CollectionDefinition.builder()
            .with_vector_service(vector_opts)
            .with_rerank(CollectionRerankOptions(service=rerank_opts))
            .build()
        )

        print(f"🚀 [Step 4/5] Transmitting provisioning command to Astra DB for: '{collection_name}'...")
        collection = self.db.create_collection(
            name=collection_name,
            definition=definition,
            embedding_api_key=self.embedding_provider,
            reranking_api_key=self.rerank_provider
        )
        return collection

    def get_existing_collection(self, collection_name: str):
        """Fetches an existing collection securely binding the agent's keys."""
        print(f"🔗 Re-binding existing cloud collection: '{collection_name}'...")
        return self.db.get_collection(
            name=collection_name,
            embedding_api_key=self.embedding_provider,
            reranking_api_key=self.rerank_provider
        )

if __name__ == "__main__":
    print("====================================================")
    print("🤖 STARTING MASTER OPERATOR INITIALIZATION ROUTINE")
    print("====================================================")
    
    try:
        agent = SupercomputerAgent()
        c_name = "super_agent_intelligence_vault"
        
        try:
            my_collection = agent.build_super_collection(c_name)
        except Exception:
            my_collection = agent.get_existing_collection(c_name)
            
        print(f"✅ Active Collection Linked: {my_collection.name}")

        print("📥 [Step 5/5] Testing pipeline: Committing document payload...")
        my_collection.insert_one({
            "_id": "doc_01",
            "$vectorize": "Supercomputer node-01 metrics are within optimal parameters.",
            "metadata": {"status": "nominal", "node": "NEXUS-NODE-BROWN"}
        })
        print("💾 Success! Document payload successfully vectorized and committed to cloud storage.")

        print("🔍 Executing immediate semantic query verification...")
        results = list(my_collection.find(
            sort={"$vectorize": "Are the supercomputer nodes running fine?"},
            limit=1
        ))

        for doc in results:
            print(f"🎉 Verification Complete! Retrieved Node Record match: {doc}")
            
    except Exception as master_error:
        print(f"\n❌ [CRITICAL AGENT ERROR]: {str(master_error)}")
        sys.exit(1)


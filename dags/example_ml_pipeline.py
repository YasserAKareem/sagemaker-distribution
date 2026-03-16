from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator

# Example ML training pipeline DAG

default_args = {
    'owner': 'ml-platform',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

def extract_data():
    """Extract data from source"""
    print("Extracting data from MinIO...")
    # Add your data extraction logic here
    return "Data extracted successfully"

def preprocess_data():
    """Preprocess and clean data"""
    print("Preprocessing data...")
    # Add your preprocessing logic here
    return "Data preprocessed successfully"

def train_model():
    """Train ML model"""
    print("Training model...")
    # Add your training logic here with MLflow tracking
    return "Model trained successfully"

def evaluate_model():
    """Evaluate model performance"""
    print("Evaluating model...")
    # Add your evaluation logic here
    return "Model evaluated successfully"

def register_model():
    """Register model in MLflow"""
    print("Registering model in MLflow...")
    # Add your model registration logic here
    return "Model registered successfully"

with DAG(
    'ml_training_pipeline',
    default_args=default_args,
    description='Example ML training pipeline',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2026, 3, 16),
    catchup=False,
    tags=['ml', 'training', 'example'],
) as dag:

    t1 = PythonOperator(
        task_id='extract_data',
        python_callable=extract_data,
    )

    t2 = PythonOperator(
        task_id='preprocess_data',
        python_callable=preprocess_data,
    )

    t3 = PythonOperator(
        task_id='train_model',
        python_callable=train_model,
    )

    t4 = PythonOperator(
        task_id='evaluate_model',
        python_callable=evaluate_model,
    )

    t5 = PythonOperator(
        task_id='register_model',
        python_callable=register_model,
    )

    # Define task dependencies
    t1 >> t2 >> t3 >> t4 >> t5

# Kubernetes MySQL Backup

Docker image for backing up a MySQL Cluster in Kubernetes using K8up and Restic.

## Usage

Install K8up and create appropriate secrets (repo secret and S3 secret).

Create a PreBackupPod spec utilising this Docker image:

```yaml
apiVersion: k8up.io/v1
kind: PreBackupPod
metadata:
  namespace: mysql-cluster
  name: mysqldump
spec:
  backupCommand: "bash /mysqlsh/backup.sh"
  pod:
    spec:
      imagePullSecrets:
        - name: githubregcreds
      containers:
        - env:
          - name: SQL_HOST
            value: mysqlcluster
          - name: SQL_USER
            value: root
          - name: SQL_PASS
            valueFrom:
              secretKeyRef:
                name: sql-pwds
                key: rootPassword
          image: ghcr.io/alex-j-butler/kubernetes-mysql-backup:test
          command:
            - 'sleep'
            - 'infinity'
          name: mysqldump
```


Finally create a schedule for the backup:

```yaml
apiVersion: k8up.io/v1
kind: Schedule
metadata:
  namespace: mysql-cluster
  name: mysql-backup-schedule
spec:
  backend:
    repoPasswordSecretRef:
      name: backup-repo
      key: password
    s3:
      endpoint: https://s3.ap-southeast-2.amazonaws.com
      bucket: example-bucket
      accessKeyIDSecretRef:
        name: backup-credentials
        key: username
      secretAccessKeySecretRef:
        name: backup-credentials
        key: password
  backup:
    schedule: '0 */2 * * *'
    failedJobsHistoryLimit: 2
    successfulJobsHistoryLimit: 2
  check:
    schedule: '30 2 * * *'
  prune:
    schedule: '0 2 * * *'
    retention:
      keepLast: 24
      keepDaily: 14
      keepWeekly: 12
      keepMonthly: 12
      keepYearly: 7
```

## Building

Run the following command to build the Docker image, replacing `[tag]` with the desired tag:

`docker build -t ghcr.io/alex-j-butler/kubernetes-mysql-backup:[tag] .`

Push the Docker file to GitHub registry:

`docker push ghcr.io/alex-j-butler/kubernetes-mysql-backup:[tag]`

### Restore Image

Build:

`docker build -t ghcr.io/alex-j-butler/kubernetes-mysql-restore:[tag] ./restore-image`

Push to GitHub registry:

`docker push ghcr.io/alex-j-butler/kubernetes-mysql-restore:[tag]`

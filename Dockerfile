FROM python:3.8

ENV CONFIG "C:\path\to\this\dir:/usr/src/app/"

# Add some extra tool
RUN apt-get update && \
    apt-get install nano
    # Clean
RUN apt-get clean && \
    apt-get autoclean
RUN rm -rf /var/lib/apt/lists/*

# Setup environment
RUN cp /usr/local/bin/pip3.8 /usr/local/bin/pip3  # reenable pip3
RUN pip3 install --upgrade pip

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Bundle app source
COPY . /usr/src/app

RUN chmod +x /usr/src/app/docker-entrypoint.sh
CMD ["/usr/src/app/docker-entrypoint.sh"]

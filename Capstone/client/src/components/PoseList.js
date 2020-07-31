import React, { useContext, useEffect } from "react";
import { PoseContext } from "../providers/PoseProvider";
import Pose from "./Pose";
import { Container, Row, Col } from 'reactstrap';


const PoseList = () => {

    const { poses, getAllPoses } = useContext(PoseContext);

    useEffect(() => {
        getAllPoses();
    }, []);

    return (

            <Container>
                <Row>
                    {poses.map((pose) => (
                        <Col sm="4">
                            <Pose key={pose.id} pose={pose} />
                        </Col>
                    ))}
                </Row>
            </Container>

    );

};

export default PoseList;
import React from "react";
import { Card, CardImg, CardBody, CardTitle, CardSubtitle } from "reactstrap";
import { useHistory } from "react-router-dom";


const Pose = ({ pose }) => {
    const history = useHistory();



    return (
        <Card onClick={() => history.push(`/pose/${pose.id}`)} className="text-center">
            <CardImg src={pose.imageLocation} alt={pose.nameEnglish} />
            <CardBody>
                <CardTitle>{pose.nameEnglish}</CardTitle>
            </CardBody>
        </Card>
    )
};

export default Pose;